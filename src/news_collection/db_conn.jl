"""
Creates the url connection string for the news table for the Quiron project.
"""
function db_conn()
    return ENV["NEWS_USER_URI"]
end