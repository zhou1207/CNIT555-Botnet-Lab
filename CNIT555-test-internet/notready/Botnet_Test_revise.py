#!/usr/bin/env python3
# encoding: utf-8

from seedemu.core import Emulator, Binding, Filter, Action #Change all seedsim to seedemu, change Simulator to Emulator 
from seedemu.services import BotnetService, BotnetClientService
from seedemu.services import DomainRegistrarService
from seedemu.compiler import Docker

sim = Emulator() #Change from Simulator to Emulator

sim.load('test-internet.bin')

bot = BotnetService()    # Create botnet service instance
bot_client = BotnetClientService() # Create botnet client service instance

#base_layer = sim.getLayer('Base') #Get Base layer in base component
#x = base_layer.getAutonomousSystem(150) # Get object of AS150
#hosts = x.getHosts() # Get hosts list in AS150

bot.install("c2_server") #.addFile(filename='ddos.py', file_src='./ddos.py')
sim.addBinding(Binding("c2_server", filter = Filter(asn = 150, ip='10.150.0.71'), action=Action.NEW))

#c2_server_ip = "10.150.0.71"

for asn in [151, 152]:
    vname = 'bot{}'.format(asn)
#    asn_base = base_layer.getAutonomousSystem(asn)
    bot_client.install(vname).setServer('c2_server')
#    c.setServer(c2_server_ip) # Remove c2_server
    sim.addBinding(Binding(vname, filter = Filter(asn = asn), action=Action.NEW))

sim.addLayer(bot)
sim.addLayer(bot_client)
sim.render()

###############################################################################

sim.compile(Docker(), './Test-Output')
