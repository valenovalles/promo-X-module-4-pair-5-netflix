const express = require('express');
const cors = require('cors');
const mysql = require("mysql2/promise")

// create and config server
const server = express();
server.use(cors());
server.use(express.json());

async function connectDB () {
  //los datos corresponden a la bd de tu ordenador
  const conex = await mysql.createConnection({
      host: "localhost",
      user: "root",
      password: "Ellie.bellie1993",
      database: "netflix"
  });
  await conex.connect();
  return conex;
}

// init express aplication
const serverPort = 4000;
server.listen(serverPort, () => {
  console.log(`Server listening at http://localhost:${serverPort}`);
});
server.get('/movies', async (req, res)=>{
  const conn = await connectDB();
    //sql -> SELECT
    const selectMovies= "SELECT * FROM movie;";
    //ejecutar el sql en la BD
    const [results] = await conn.query(selectMovies);
    console.log(results)
    //respondo con los datos
    res.json({success : true, movies: results});

});

const staticServerPathWeb = 'src/public-react'; // En esta carpeta ponemos los ficheros estáticos
server.use(express.static(staticServerPathWeb));

const staticServerPathImage = 'src/public-movies-images'; // En esta carpeta ponemos los ficheros estáticos
server.use(express.static(staticServerPathImage));