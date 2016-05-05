require_relative "./_configure"

DB.define_table("users")
DB.define_column("users","first_name","string")
DB.define_column("users","last_name","string")
DB.define_column("users","email", "string")
DB.define_column("users","password","string")
DB.define_column("users","debt_amount","float")
DB.define_column("users", "active", "boolean")
DB.define_column("users", "confirm_token", "string")

DB.define_table("investments")
DB.define_column("investments","investor_user_id","integer")
DB.define_column("investments","student_user_id","integer")
DB.define_column("investments","amount","float")
DB.define_column("investments","paid","boolean")

DB.define_table("updates")
DB.define_column("updates","user_id","integer")
DB.define_column("updates","status_update","string")