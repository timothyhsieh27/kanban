require_relative 'environment'
#
class CreateTasksTable < ActiveRecord::Migration[5.0]
  def up
    create_table :tasks do |task|
      task.string :title
      task.string :status
      task.string :priority
    end
  end

  def down
    drop_table :AllTasks
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreateTasksTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
