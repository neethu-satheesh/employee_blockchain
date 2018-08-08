module EmployeeExperienceStateMachine
  def self.extended(base)
    base.aasm column: :status do
      state :pending, initial: true
      state :approved
      state :rejected

      event :approve do
        transitions to: :approved
        after do
          BlockchainJob::CreateEmployeeExperienceJob.perform_later(self)
        end
      end

      event :reject do
        transitions to: :rejected
      end
    end
  end
end
