import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { ApiService } from '../../../services/api.service';


@Component({
  selector: 'app-list-clientes',
  templateUrl: './list-clientes.component.html',
  styleUrls: ['./list-clientes.component.scss']
})
export class ListClientesComponent implements OnInit {

	public users: any = [];
	public action: string = "";

	private actual_id: string = "";

	public user: any = {
		Id: "",
		PrimerNombre: "",
		SegundoNombre: "",
		PrimerApellido: "",
		SegundoApellido: "",
		TipoDocumento: "",
		Documento: "",
		EMail: "",
		Celular: "",
		Direccion: ""
	}


	constructor(private service: ApiService, private router: Router) { }

	ngOnInit(): void {
		let logged = localStorage.getItem("Logged");
			if(logged != null){
				if(logged == "false")
					this.router.navigate(["home"]);
			}

		this.service.getClientes((data) => {
			this.service.closeDialog();
			if(data.hasOwnProperty("error")) this.service.presentToast("¡Error!", "Algo paso: " + data.msg , "error");
			else{				
				this.users = data;
			}
		});
	}

	toNew(){
		this.action = "save";
		this.user.Id = this.users.length + 1;
		this.user.PrimerNombre = "";
		this.user.SegundoNombre = "";
		this.user.PrimerApellido = "";
		this.user.SegundoApellido = "";
		this.user.TipoDocumento = "";
		this.user.Documento = "";
		this.user.EMail = "";
		this.user.Celular = "";
		this.user.Direccion = "";
	}

	guardar(){

		if(this.user.PrimerNombre == "" || this.user.SegundoNombre == ""){ 
			this.service.presentToast("¡Error!", "Los nombres no pueden ser vacío", "error");
			return;
		}
		if(this.user.PrimerApellido == "" || this.user.SegundoApellido == "") {
			this.service.presentToast("¡Error!", "Los apellidos no pueden ser vacío", "error");
			return;
		}
		if(this.user.TipoDocumento == "") {
			this.service.presentToast("¡Error!", "Debes seleccionar un tipo de documento", "error");
			return;
		}
		if(this.user.Documento == "") {
			this.service.presentToast("¡Error!", "La cédula no puede ser vacío", "error");
			return;
		}
		if(this.user.EMail == "") {
			this.service.presentToast("¡Error!", "El correo no puede ser vacío", "error");
			return;
		}
		
		let regPhone = new RegExp("^[0-9]*$");
		let regMail = new RegExp("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+).+(\.[a-zA-Z0-9-])*$");
		if(!regPhone.test(this.user.Documento)) {
			this.service.presentToast("¡Error!", "La cédula solo pueden ser números", "error");
			return;
		}

		if(!regMail.test(this.user.EMail)){
			this.service.presentToast("¡Error!", "El correo ingresado no es un correo valido", "error");
			return;
		}

		if(this.action == "save") this.doGuardar();
		else this.doEditar();
		
	}

	doEditar(){
		this.user._id = this.actual_id;
		this.service.putClientes(this.user, (data) => {
			this.service.closeDialog();
			if(data.hasOwnProperty("error")) this.service.presentToast("¡Error!", "Algo paso: " + data.msg, "error");
			else{
				this.user.Id = "";
				this.user.PrimerNombre = "";
				this.user.SegundoNombre = "";
				this.user.PrimerApellido = "";
				this.user.SegundoApellido = "";
				this.user.TipoDocumento = "";
				this.user.Documento = "";
				this.user.EMail = "";
				this.user.Celular = "";
				this.user.Direccion = "";
				this.service.hideModal("#agregarUser");
				this.ngOnInit();
			}
		});
	}

	doGuardar(){
		//if( this.user.hasOwnProperty("Id")) delete this.user.Id;
		this.service.setClientes(this.user, (data) => {
			this.service.closeDialog();
			if(data.hasOwnProperty("error")) this.service.presentToast("¡Error!", "Algo paso: " + data.msg, "error");
			else{
				this.user.Id = "";
				this.user.PrimerNombre = "";
				this.user.SegundoNombre = "";
				this.user.PrimerApellido = "";
				this.user.SegundoApellido = "";
				this.user.TipoDocumento = "";
				this.user.Documento = "";
				this.user.EMail = "";
				this.user.Celular = "";
				this.user.Direccion = "";
				this.service.hideModal("#agregarUser");
				this.ngOnInit();
			}
		});
	}


	editar(user){
		this.actual_id = user.Id;
		this.user.Id = user.Id;
		this.user.PrimerNombre = user.PrimerNombre;
		this.user.SegundoNombre = user.SegundoNombre;
		this.user.PrimerApellido = user.PrimerApellido;
		this.user.SegundoApellido = user.SegundoApellido;
		this.user.TipoDocumento = user.TipoDocumento;
		this.user.Documento = user.Documento;
		this.user.EMail = user.EMail;
		this.user.Celular = user.Celular;
		this.user.Direccion = user.Direccion;

		this.action = "edit";
		this.service.presentModal("#agregarUser");
	}

	eliminar(user){
		console.log(user)
		let confirmar = (result) => {
	      if (result.isConfirmed) {  
	        let _id = user.Id;

	        this.service.delClientes({ _id: _id }, (data) =>{
	          this.service.closeDialog();
	          if(data.hasOwnProperty("error")) this.service.presentToast("¡Algo paso!", data.message, "error");
	          else this.service.presentToast("¡Hecho!", "Evento eliminado");
	          this.ngOnInit();
	        });            
	      }
	    };

	    let buttons = {
	        showCancelButton: true,
	        cancelButtonText: 'Cancelar',
	        confirmButtonColor: '#3085d6',
	        cancelButtonColor: '#d33',
	        confirmButtonText: 'Confirmar'
	      }
		this.service.presentAlertConfirm("¡Atención!", "¿Deseas borrar?", buttons, confirmar)
	}


	salir(){
		localStorage.setItem("Logged", "false");
		this.router.navigate(["home"]);
	}

}
