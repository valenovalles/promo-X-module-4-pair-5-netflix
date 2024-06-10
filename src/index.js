const express = require('express');
const cors = require('cors');
const mysql = require("mysql2/promise");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

// create and config server
const server = express();
server.use(cors());
server.use(express.json());
server.set('view engine', 'ejs');

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

server.get('/movie/:idMovies', async (req, res) => { 
  const conn = await connectDB();
  const {idMovies} = req.params;
  console.log(idMovies);
  const select = "SELECT * FROM movie WHERE idMovies = ?"

  const [result] = await conn.query ( select, [idMovies])
  res.render ("detailMovie", {movie: result[0]});
  conn.end()

})

server.post('/signup', async (req, res)=>{
  //conectar DB
  const conex = await connectDB();
  //recoger datos usuario
  const {email, password} = req.body;
  //comprobar que no exista ya en DB
  const selectEmail = "SELECT * FROM user WHERE email = ?;";
  const [emailResult] = await conex.query(selectEmail, [email]);
  //si no existe: insert into
  if(emailResult.length === 0){
    const hashedPassword = await bcrypt.hash(password, 10);
    const insertUser = "INSERT INTO user (email, password) VALUES (?, ?);";
    const [newUser] = await conex.query(insertUser, [email, hashedPassword]);
    res.status(201).json({success: true, userId: newUser.insertId})
  } else{ //si existe: responder con msg ya estas registrada
    res.status(201).json({success: false, message: "Este usuario ya existe"});
  };
  await conex.end();
})

const staticServerPathWeb = 'src/public-react'; // En esta carpeta ponemos los ficheros estáticos
server.use(express.static(staticServerPathWeb));

const staticServerPathImage = 'src/public-movies-images'; // En esta carpeta ponemos los ficheros estáticos
server.use(express.static(staticServerPathImage));

server.use(express.static("./src/css"));