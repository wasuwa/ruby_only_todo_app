class Task
  def initialize(title: 'タイトルなし', content: '内容なし', goal_at: default_goal_at)
    @title   = title
    @content = content
    @goal_at = goal_at
  end

  def destroy
    # SQLを削除
  end

  private

    def create
      # SQLを発行
    end

    def default_goal_at
      Time.now + tomorrow
    end

    def tomorrow
      24 * 60 * 60
    end
end

p a = Task.new
