require 'simplecov'
SimpleCov.start

require_relative '../files/service'
require_relative '../files/serviceProvider'
require_relative '../files/appointment'
require_relative '../files/timeblock'
require_relative '../lib/print'
require_relative '../seeder/init'
require_relative '../lib/colors'
require_relative '../files/availability'
require 'date'
# require 'launchy'

RSpec.describe ServiceProvider do
    describe "#serviceAdd" do
        describe "add service that sp does not have" do
            it "should add service to sp's services" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv = Service.new("hugs", 0, 180)
                sp.serviceAdd(serv)
                expect(sp.services.include?(serv)).to eq(true)
            end
        end
    end



    describe "#serviceRemove" do
        describe "remove service that sp has" do
            it "should remove service from sp's services" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv1 = Service.new("hugs", 0, 180)
                serv2 = Service.new("shrugs", 3, 60)
                sp.serviceAdd(serv1)
                sp.serviceAdd(serv2)
                sp.serviceRemove(serv1.name)
                expect(sp.services.include?(serv1)).to eq(false)
            end
        end

        describe "sp does not have service" do
            it "should do nothing" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv1 = Service.new("hugs", 0, 180)
                serv2 = Service.new("shrugs", 3, 60)
                sp.serviceAdd(serv1)
                test_services_length = 1
                sp.serviceRemove(serv2.name)
                expect(sp.services.length).to eq(test_services_length)
            end
        end
    end



    describe "#containsService" do
        describe "check service that sp has" do
            it "returns true" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv1 = Service.new("hugs", 0, 180)
                sp.serviceAdd(serv1)
                expect(sp.containsService(serv1.name)).to eq(serv1)
            end
        end

        describe "check service that sp does not have" do
            it "returns false" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv1 = Service.new("hugs", 0, 180)
                serv2 = Service.new("shrugs", 3, 60)
                sp.serviceAdd(serv1)
                expect(sp.containsService(serv2.name)).to eq(false)
            end
        end
    end



    describe "#add_availability" do
        describe "add availability that sp does not have" do
            it "should add availability to sp's availability" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                av = TimeBlock.new(DateTime.new(2019, 12, 12, 12), false, 120)
                sp.add_availability(av)
                expect(sp.availability.include?(av)).to eq(true)
            end
        end
    end



    describe "#is_available" do
        describe "no conflicts with appointments" do
            it "should return true" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv1 = Service.new("hugs", 0, 180)
                serv2 = Service.new("shrugs", 3, 60)
                sp.serviceAdd(serv1)
                sp.serviceAdd(serv2)
                tb1 = TimeBlock.new(DateTime.new(2019, 12, 12, 12), false, 120)
                tb2 = TimeBlock.new(DateTime.new(2019, 11, 11, 11), false, 120)
                sp.add_appointment(serv1, tb1, 'bill')
                expect(sp.is_available(serv2, tb2, false)).to eq(true)
            end
        end

        describe "conflict with appointments" do
            it "should return false" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv1 = Service.new("hugs", 0, 180)
                serv2 = Service.new("shrugs", 3, 60)
                sp.serviceAdd(serv1)
                sp.serviceAdd(serv2)
                tb1 = TimeBlock.new(DateTime.new(2019, 12, 12, 12), false, 120)
                sp.add_appointment(serv1, tb1, 'bill')
                expect(sp.is_available(serv2, tb1, false)).to eq(false)
            end
        end

        # describe "no conflicts with availability" do
        #     it "should return true" do
        #         sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
        #         av = TimeBlock.new(DateTime.new(2019, 12, 12, 12), false, 120)
        #         sp.add_availability(av)
        #     end
        # end

        # describe "conflict with availability" do
        #     it "should return false" do
        #         sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
        #         av = TimeBlock.new(DateTime.new(2019, 12, 12, 12), false, 120)
        #         sp.add_availability(av)
        #     end
        # end
    end



    describe "#add_appointment" do
        describe "add appointment with no conflicts" do
            it "should add appointment to sp's appointments" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv1 = Service.new("hugs", 0, 180)
                sp.serviceAdd(serv1)
                tb1 = TimeBlock.new(DateTime.new(2019, 12, 12, 12), false, 120)
                tb2 = TimeBlock.new(DateTime.new(2019, 11, 11, 11), false, 120)
                sp.add_appointment(serv1, tb1, 'bill')
                expect(sp.add_appointment(serv1, tb2, 'bill')).to eq(true)
            end
        end

        describe "add appointment with conflicts" do
            it "should print an error message and return false" do
                sp = ServiceProvider.new("waluigi", 1111111111, [], [], [])
                serv1 = Service.new("hugs", 0, 180)
                serv2 = Service.new("shrugs", 3, 60)
                sp.serviceAdd(serv1)
                sp.serviceAdd(serv2)
                tb1 = TimeBlock.new(DateTime.new(2019, 12, 12, 12), false, 120)
                sp.add_appointment(serv1, tb1, 'bill')
                expect(sp.add_appointment(serv2, tb1, 'bill')).to eq(false)
            end
        end
    end
end

# Launchy::Browser.run("./coverage/index.html")