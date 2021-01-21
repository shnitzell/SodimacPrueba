/* * * * * * * * * * * * * * * * * *
* Luis Romero - 1082994898, Prueba BackEndNode
*
*
* * * * * * * * * * * * * * * * * */


/******Conexión ********/
const path = require('path');
var app = require('express')();
var fs = require('fs');
var cors = require('cors');
var bodyParser = require('body-parser');

var exports=module.exports={};

/********Configurando Base de datos******/
var ObjectID = require('mongodb').ObjectID;
var MongoClient = require('mongodb').MongoClient;
/**************************/

var dbConnection;
//process.env['NODE_TLS_REJECT_UNAUTHORIZED'] = 0

app.use(cors());
app.use(bodyParser.json({ limit: '30mb', extended: true }));
app.use(bodyParser.urlencoded({ extended: true }));
app.listen(3000);

/************Home Page*************/
app.get('/', function(req, res) {
  res.status(200).sendFile( path.join(__dirname + '/index.html') );  
  return;
});

async function initialiteRoutes(){
  /********Conexión Base de datos******/
  var dbhost = "mongodb://localhost:27017/";

  var db = await MongoClient.connect(dbhost, { journal: true, useNewUrlParser: true, 
                                               useUnifiedTopology: true })
                .catch(err => {  
                    console.log("no se pudo conectar a la db", err);
                });

  if (!db) return;
  dbConnection = db.db('sisusers');
  console.log("Connected to db");

  require('./routes/authuser-routes.js')(app, dbConnection, ObjectID);
}

initialiteRoutes();