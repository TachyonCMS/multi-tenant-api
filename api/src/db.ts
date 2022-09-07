import { userInfo } from 'os'
import postgres from 'postgres'

const PGUSER: string = process.env.PGUSER;
const PGPASSWORD: string = process.env.PGPASSWORD;
console.log(process.env.PORT)

console.log(PGPASSWORD)

const sql = postgres({
    host                 : '',            // Postgres ip address[s] or domain name[s]
    port                 : 5432,          // Postgres server port[s]
    database             : 'app',            // Name of database to connect to
    username             : 'appuser',            // Username of database user
    password             : 'appuserpassword',            // Password of database user
  }) // will use psql environment variables

export default sql