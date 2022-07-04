class Comuna {
  var nombre;
  var numeroBarrios;
  var comunaId;
  var presidenteComunaId;

  Comuna({
    this.comunaId,
    this.nombre, 
    this.numeroBarrios, 
    this.presidenteComunaId
    });

    Map<String, dynamic> toJson() => {
        'comunaId': comunaId,
        'nombre': nombre,
        'numeroBarrios': numeroBarrios,
        'presidenteComunaId': presidenteComunaId
      };

}
