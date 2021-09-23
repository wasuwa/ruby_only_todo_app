require_relative 'sql'

class TODO
  def initialize(title: 'タイトルなし', content: '内容なし', goal_at: default_goal_at)
    create(title, content, goal_at)
  end

  def destroy
    # SQLを削除
  end

  private

    def create(title, content, goal_at)
      sql = SQL.new('../../database.yml', 'tasks')
      sql.create(all_columns, [title, content, goal_at])
    end

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

a = Task.new
