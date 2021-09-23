require_relative 'todo/sql'

class Todo
  def initialize
    @sql = SQL.new('../database.yml', 'tasks')
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
end

# SQL.new('../database.yml', 'tasks').index.each do |i|
#   puts i
# end
