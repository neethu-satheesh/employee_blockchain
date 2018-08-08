require 'empex_blockchain/client'

module BlockchainJob
  class CreateOrganizationJob < ApplicationJob

    def perform(organization)
      EmpexBlockchain::Client.create_organization(organization)
    end
  end
end
