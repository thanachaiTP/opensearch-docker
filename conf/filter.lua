function cb_main(tag, timestamp, record)
    local code = 2
    local msg = record.message
    local p1 = '.?for (%w+%-?%w+) from.?'
    local p2 = '.?user (%w+%-?%w+)'
    local p3 = '.?user=(%w+%-?%w+)'
    local p4 = '(%w+%-?%w+).*incorrect password attempts.?'
    local sudo_user, sudo_by
    local user = msg:match(p1) or msg:match(p2) or msg:match(p3) or msg:match(p4)
    local from = msg:match('.?(%d+%.%d+%.%d+%.%d+)')
    local logged_in_with = msg:match('Accepted (%w+).?')
    local success = msg:match('session opened') or msg:match('New session')

    record.success = false
    if success then
        record.success = true
    end

    if logged_in_with then
        record.login_with = logged_in_with
        record.success = true
    elseif msg:match('Failed password.?') or msg:match(p4) then
        record.login_with = 'password'
    end

    sudo_user, sudo_by = msg:match('.*session opened for user (%w+%-?%w+) by (%w+%-?%w+).?')
    if sudo_user and sudo_by then
        record.sudo_user = sudo_user
        record.success = true
        record.sudo_by = sudo_by
    end

    record.user = user
    record.from = from
    return code, timestamp, record
end

