module.exports = function (app, dbConnection, ObjectID) {

/**********Registra un usuario***********/
app.post('/api/user/set', function(req, res) {  
  var rq = req.body;
  var user = String(rq.mail).toLowerCase().trim();

  let regPhone = new RegExp("^[0-9]*$");
  let regMail = new RegExp("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+).+(\.[a-zA-Z0-9-])*$");

  if(!regMail.test(rq.mail)){
    res.send({ error: true, message: 'Email no es valido' });
    return;
  }else{
    if(!regPhone.test(rq.document)){
      res.send({ error: true, message: 'La cédula no es valida, debe incluir solo números' });
      return;
    }
      
    dbConnection.collection('users').findOne({
      '$or': [
        { 'mail': rq.mail },
        { 'document': rq.document }
      ]
    }).then( function(doc) {
      if(!doc) {     
        dbConnection.collection('users').insertOne( rq, function(err, data) {
          if(err) res.send({ error: true, message: 'No se pudo crear usuario' });
          else res.send({ success: true });           
          return;
        });        
      }else res.send({ error: true, message: 'Ya existe un usuario con el correo ' + rq.email + ' o la cédula ' + rq.document });
      return;
    });

  }
});
/**********Retorna los usuarios**********/
app.post('/api/user/list', function(req, res) {    
  dbConnection.collection('users').find({}).toArray( function(err, doc) {
      if(err) res.send({ error: true, message: 'No se pudo obtener la lista de usuarios' });
      else  res.send(doc);
      return;
  });
  return;
});
/**********Elimina el usuarios***********/
app.post('/api/user/del', function(req, res) {  
  
  var rq = req.body;  
  dbConnection.collection('users').deleteOne({ _id: new ObjectID(rq._id) }, function(err, data) {
    if(err) res.send({ error: true, message: 'Usuario no existe' });
    else res.send({ success: true, res: data });
    return;
  });
  return;
});
/**********Actualiza los datos de usuario***********/
app.post('/api/user/put', function(req, res) {  
  var rq = req.body;  
  
  var _id = new ObjectID(rq._id);
  delete rq._id;

  dbConnection.collection('users')
  .findOneAndUpdate({ '_id': _id }, { $set: rq }, {}, function(err, object) {
        if (err) res.send({ error: true, message: err.message });
        else res.send({ message: 'Actualizado' });
        return;           
  });
  
});
}