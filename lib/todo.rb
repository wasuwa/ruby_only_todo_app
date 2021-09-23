require_relative 'todo/sql'

class Todo
  def initialize
    @sql = SQL.new('../database.yml', 'tasks')
  end

  def list
    @sql.index.each do |record|
      puts change_format_of_task(record)
    end
  end

  def individual_display(id)
    @sql.show(id).each do |record|
      puts change_format_of_task(record)
    end
  end

  def create(title: 'タイトルなし', content: '内容なし', goal_at: default_goal_at)
    @sql.create(all_columns, [title, content, goal_at])
  end

  def destroy(id)
    @sql.destroy(id)
  end

  private

    def all_columns
      ['title', 'content', 'goal_at']
    end

    def default_goal_at
      Time.now + tomorrow
    end

    def tomorrow
      24 * 60 * 60
    end

    def change_format_of_task(task)
      line = '-' * 40
      <<~TEXT
        #{line}
        id:           #{task['id']}
        タイトル:     #{task['title']}
        内容:         #{task['content']}
        完了予定時刻: #{task['goal_at']}
        #{line}
      TEXT
    end
end
