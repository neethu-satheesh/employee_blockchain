# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

Role.create([{ name: 'admin' }, { name: 'employee' }, { name: 'organization' }])

role = Role.find_by(name: 'admin')
User.create(email: 'admin@empex.com', password: 'admin123', password_confirmation: 'admin123', role_id: role.id)
