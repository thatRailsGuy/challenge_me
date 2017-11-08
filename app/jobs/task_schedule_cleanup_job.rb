class TaskScheduleCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    TaskSchedule.process_expired
  end
end
