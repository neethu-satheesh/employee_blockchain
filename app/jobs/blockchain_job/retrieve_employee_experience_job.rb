require 'empex_blockchain/client'

module BlockchainJob
  class RetrieveEmployeeExperienceJob < ApplicationJob

    def perform(employee_experience, employee)
      EmpexBlockchain::Client.retrieve_employee_experience(employee_experience, employee)
    end
  end
end
