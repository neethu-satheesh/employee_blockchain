require 'empex_blockchain/client'

module BlockchainJob
  class CreateEmployeeExperienceJob < ApplicationJob

    def perform(employee_experience)
      EmpexBlockchain::Client.create_employee_experience(employee_experience)
    end
  end
end
