class TaskSchedule < ApplicationRecord
    belongs_to :user

    def mark_complete
        create_task(true)
    end

    def mark_incomplete
        create_task(false)
    end

    def self.process_expired
        self.where(['due_date < ?', DateTime.now]).find_each do |task_schedule|
            task_schedule.mark_incomplete
        end
        TaskScheduleCleanupJob.set(wait: Figaro.env.task_schedule_cleanup_job_wait_time.to_i).perform_later
    end

    private
    def create_task(is_complete)
        task = nil
        ActiveRecord::Base.transaction do
          task = Task.create(name: name, completed: is_complete, due_date: due_date, user_id: user_id)
          self.destroy
        end
        task
    end
end
