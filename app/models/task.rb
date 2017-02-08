class Task < ApplicationRecord
	include AASM

	validates :text, presence: true

	aasm do
		state :uncompleted, initial: true
		state :on_progress
		state :completed

		event :complete do
			transitions from: [:uncompleted, :on_progress], to: :completed
		end

		event :unfinish do
			transitions from: [:uncompleted, :completed], to: :on_progress
		end

		event :uncomplete do
			transitions from: [:on_progress, :completed], to: :uncompleted
		end
	end
end
