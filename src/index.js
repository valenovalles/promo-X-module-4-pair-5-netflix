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
      user: process.env.DB_USER,
      password: process.env.DB_PASS,
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
    //query params
    const genreFilterParam = req.query.genre;
    console.log(genreFilterParam)
    //sql -> SELECT
    let data;
    if (genreFilterParam === ""){
      const selectMovies= "SELECT * FROM movie;";
      const [results] = await conn.query(selectMovies);
      data = results;
    } else{
      const selectMovies= "SELECT * FROM movie WHERE genre = ?;";
      const [results] = await conn.query(selectMovies, [genreFilterParam]);
      data = results;
    };  
    //respondo con los datos
    res.json({success : true, movies: data});

});

const staticServerPathWeb = 'src/public-react'; // En esta carpeta ponemos los ficheros estáticos
server.use(express.static(staticServerPathWeb));

const staticServerPathImage = 'src/public-movies-images'; // En esta carpeta ponemos los ficheros estáticos
server.use(express.static(staticServerPathImage));