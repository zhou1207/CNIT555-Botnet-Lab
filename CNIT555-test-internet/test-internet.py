#!/usr/bin/env python3
# encoding: utf-8

from seedemu.layers import Base, Routing, Ebgp, Ibgp, Ospf, PeerRelationship, Dnssec
from seedemu.services import WebService, DomainNameService, DomainNameCachingService, BotnetService, BotnetClientService
#from seedemu.services import CymruIpOriginService, ReverseDomainNameService, BgpLookingGlassService
from seedemu.compiler import Docker, Graphviz
#from seedemu.hooks import ResolvConfHook
from seedemu.core import Emulator, Service, Binding, Filter
from seedemu.layers import Router
#from seedemu.raps import OpenVpnRemoteAccessProvider
#from seedemu.utilities import Makers

from typing import List, Tuple, Dict

BYOB_VERSION='3924dd6aea6d0421397cdf35f692933b340bfccf'

###################################################################

emu     = Emulator()
base    = Base()
routing = Routing()
ebgp    = Ebgp()
ibgp    = Ibgp()
ospf    = Ospf()
web     = WebService()
#ovpn    = OpenVpnRemoteAccessProvider()

###################################################################

# Create an Internet Exchange
ix100 = base.createInternetExchange(100)

####################################################################

# Create botnet service and client service instance
bot = BotnetService()
bot_client = BotnetClientService()

###############################################################################
# Create and set up AS-150

# Create an autonomous system
as150 = base.createAutonomousSystem(150)

# Create a network
as150.createNetwork('net0')

# Create a router and connect it to two networks
as150.createRouter('router0').joinNetwork('net0').joinNetwork('ix100')

# Create a host called web and connect it to a network
as150.createHost('web').joinNetwork('net0')
# Create a host called test and connect it to a netowrk. It will be the victim.
as150.createHost('test').joinNetwork('net0', address = '10.150.0.80')

#Install additional software and build command for byob client payload to run on victim
test = as150.getHost('test')
test.addSoftware('python3 git cmake python3-dev gcc g++ make python3-pip')
test.addSoftware('wget nmap')
test.addBuildCommand('curl https://raw.githubusercontent.com/malwaredllc/byob/{}/byob/requirements.txt > /tmp/byob-requirements.txt'.format(BYOB_VERSION))
test.addBuildCommand('pip3 install -r /tmp/byob-requirements.txt')
test.addBuildCommand('pip3 install scapy')

# Create a bot and connect it to a network.
as150.createHost('bot1_150').joinNetwork('net0')
as150.createHost('c2_server').joinNetwork('net0')

# Build command on c2 server
c2_server = as150.getHost('c2_server')
c2_server.addBuildCommand('pip3 install scapy')
c2_server.addSoftware('wget')

# Build command on bot
bot1 = as150.getHost('bot1_150')
bot1.addBuildCommand('pip3 install scapy')
bot1.addSoftware('wget')

# Create a web service on virtual node, give it a name
# This will install the web service on this virtual node
# For entry level, add the payload file directly to /var/www/html/downloads/
# Need to first mkdir the downloads directory!!!!!
f = open("./byob_client_dropper_runner.sh", "r")
web.install('web150').addFile(f.read(), "/tmp/byob_client_dropper_runner.sh")

# Add the /etc/nginx/sites-enabled/default file to web server to replace
f = open("./default", "r")
web.install('web150').addFile(f.read(), "/tmp/default")

# Add the ddos.py file to the web host
f = open("./ddos.py", "r")
web.install('web150').addFile(f.read(), "/tmp/ddos.py")

# Create a bot server service on virtual node, give it a name
# This will install the byob botnet c2 server on this virtual node
f = open("./ddos.py", "r")
bot.install('c2_server').addFile(f.read(), "/tmp/ddos.py")

# Create a bot client service on virtual node, give it a name
# This will install the byob client service on this virtual node
f = open("./ddos.py", "r")
bot_client.install('bot1_150').setServer('c2_server').addFile(f.read(), "/tmp/ddos.py")

# Bind the virtual node to a physical node
emu.addBinding(Binding('web150', filter = Filter(nodeName = 'web', asn = 150)))
emu.addBinding(Binding('c2_server', filter = Filter(nodeName = 'c2_server', asn=150)))
emu.addBinding(Binding('bot1_150', filter = Filter(nodeName = 'bot1_150', asn=150)))


###############################################################################
# Create and set up AS-151
# It is similar to what is done to AS-150

as151 = base.createAutonomousSystem(151)
as151.createNetwork('net0')
as151.createRouter('router0').joinNetwork('net0').joinNetwork('ix100')

as151.createHost('web').joinNetwork('net0')
web.install('web151')

# Add additional software/command utility to web host
web151 = as151.getHost('web')
web151.addSoftware('net-tools nmap')

# Create a bot and connect it to a network.
as151.createHost('bot2_151').joinNetwork('net0')

# Build command on bot
bot2 = as151.getHost('bot2_151')
bot2.addBuildCommand('pip3 install scapy')
bot2.addSoftware('wget')

# Create a bot client service on virtual node, give it a name
# This will install the byob client service on this virtual node
f = open("./ddos.py", "r")
bot_client.install('bot2_151').setServer('c2_server').addFile(f.read(), "/tmp/ddos.py")

emu.addBinding(Binding('bot2_151', filter = Filter(nodeName = 'bot2_151', asn=151)))
emu.addBinding(Binding('web151', filter = Filter(nodeName = 'web', asn = 151)))

###############################################################################
# Create and set up AS-152
# It is similar to what is done to AS-150


as152 = base.createAutonomousSystem(152)
as152.createNetwork('net0')
as152.createRouter('router0').joinNetwork('net0').joinNetwork('ix100')

as152.createHost('web').joinNetwork('net0')
web.install('web152')

# Add additional software/command utility to web host
web152 = as152.getHost('web')
web152.addSoftware('net-tools nmap')


emu.addBinding(Binding('web152', filter = Filter(nodeName = 'web', asn = 152)))


###############################################################################
# Peering these ASes at Internet Exchange IX-100

ebgp.addRsPeer(100, 150)
ebgp.addRsPeer(100, 151)
ebgp.addRsPeer(100, 152)


###############################################################################
# Rendering

emu.addLayer(base)
emu.addLayer(routing)
emu.addLayer(ebgp)
emu.addLayer(web)
emu.addLayer(bot)
emu.addLayer(bot_client)

emu.render()

###############################################################################
# Compilation

emu.compile(Docker(), './Testoutput')
