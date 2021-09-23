require 'pg'
require 'yaml'

class SQL
  def initialize(setting_yaml_path, table_name)
    dbconf = YAML.load_file("#{setting_yaml_path}")['db']['development']
    @connect = PG::connect(dbconf)
    @table_name = table_name
  end

  def index
    @connect.exec("SELECT * FROM #{@table_name}")
  end

  def create(columns, values)
    sql_enabled_values = change_values_to_sql_format(values)
    insert = %(INSERT INTO #{@table_name}(#{columns.join(', ')}) VALUES(#{sql_enabled_values});)
    @connect.exec(insert)
  end

  def destroy(id)
    @connect.exec("DELETE FROM #{@table_name} WHERE id = #{id};")
  end

  private

    def change_values_to_sql_format(values)
      text = ""
      values.each do |value|
        if value.is_a?(String)
          text << %('#{value}')
        elsif value.is_a?(Time)
          text << %('#{change_time_format(value)}')
        else
          text << %(#{value})
        end
        text << ', ' unless value == values[-1]
      end
      text
    end

    def change_time_format(time)
      time.strftime("%F %T")
    end
end
