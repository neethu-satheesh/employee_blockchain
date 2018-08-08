require 'empex_blockchain/client'

module BlockchainJob
  class RetrieveEmployeeJob < ApplicationJob

    def perform(employee)
      EmpexBlockchain::Client.retrieve_employee(employee)
    end
  end
end
