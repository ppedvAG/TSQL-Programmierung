select st.name,sd.name from sys.databases sd
inner join sys.login_token st on st.sid=sd.owner_sid

select * from sys.login_token