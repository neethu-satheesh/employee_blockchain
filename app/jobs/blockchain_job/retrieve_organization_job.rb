require 'empex_blockchain/client'

module BlockchainJob
  class RetrieveOrganizationJob < ApplicationJob

    def perform(organization)
      EmpexBlockchain::Client.retrieve_organization(organization)
    end
  end
end
