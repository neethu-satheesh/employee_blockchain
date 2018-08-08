require 'empex_blockchain/client'

module BlockchainJob
  class CreateEmployeeJob < ApplicationJob

    def perform(employee)
      EmpexBlockchain::Client.create_employee(employee)
    end
  end
end
