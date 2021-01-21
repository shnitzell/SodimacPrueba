import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { ApiService } from '../../../services/api.service';


@Component({
  selector: 'app-list-user',
  templateUrl: './list-user.component.html',
  styleUrls: ['./list-user.component.scss']
})
export class ListUserComponent implements OnInit {

	public users: any = [];
	public action: string = "";

	private actual_id: string = "";

	public user: any = {
		givenname: "",
		lastname: "",
		document: "",
		mail: "",
		phone: "",
	}


	constructor(private service: ApiService, private router: Router) { }

	ngOnInit(): void {
		let logged = localStorage.getItem("Logged");
			if(logged != null){
				if(logged == "false")
					this.router.navigate(["home"]);
			}

		this.service.getUser((data) => {
			this.service.closeDialog();
			if(data.hasOwnProperty("error")) this.service.presentToast("¡Error!", "Algo paso" + data.msg );
			else{
				for(let d of data){
					if(d.hasOwnProperty("GivenName")){
						d["id"] = d.Id;
						d["givenname"] = d.GivenName;
						d["lastname"] = d.LastName;
						d["document"] = d.Document;
						d["mail"] = d.Mail;
						d["phone"] = d.Phone;
					}
				}
				this.users = data;
			}
		});
	}

	toNew(){
		this.action = "save";
		this.user._id = "";
		this.user.givenname = "";
		this.user.lastname = "";
		this.user.document = "";
		this.user.mail = "";
		this.user.phone  = "";
	}

	guardar(){

		if(this.user.givenname == ""){ 
			this.service.presentToast("¡Error!", "Los nombres no pueden ser vacío", "error");
			return;
		}
		if(this.user.lastname == "") {
			this.service.presentToast("¡Error!", "Los apellidos no pueden ser vacío", "error");
			return;
		}
		if(this.user.document == "") {
			this.service.presentToast("¡Error!", "La cédula no puede ser vacío", "error");
			return;
		}
		if(this.user.mail == "") {
			this.service.presentToast("¡Error!", "El correo no puede ser vacío", "error");
			return;
		}
		
		let regPhone = new RegExp("^[0-9]*$");
		let regMail = new RegExp("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+).+(\.[a-zA-Z0-9-])*$");
		if(!regPhone.test(this.user.document)) {
			this.service.presentToast("¡Error!", "La cédula solo pueden ser números", "error");
			return;
		}

		if(!regMail.test(this.user.mail)){
			this.service.presentToast("¡Error!", "El correo ingresado no es un correo valido", "error");
			return;
		}

		if(this.action == "save") this.doGuardar();
		else this.doEditar();
		
	}

	doEditar(){
		this.user._id = this.actual_id;
		this.service.putUser(this.user, (data) => {
			this.service.closeDialog();
			if(data.hasOwnProperty("error")) this.service.presentToast("¡Error!", "Algo paso" + data.msg );
			else{
				this.user.givenname = "";
				this.user.lastname = "";
				this.user.document = "";
				this.user.mail = "";
				this.user.phone  = "";
				this.service.hideModal("#agregarUser");
				this.ngOnInit();
			}
		});
	}

	doGuardar(){
		if( this.user.hasOwnProperty("_id")) delete this.user._id;
		if( this.user.hasOwnProperty("id")) delete this.user.id;

		this.service.setUser(this.user, (data) => {
			this.service.closeDialog();
			if(data.hasOwnProperty("error")) this.service.presentToast("¡Error!", "Algo paso" + data.msg );
			else{
				this.user.givenname = "";
				this.user.lastname = "";
				this.user.document = "";
				this.user.mail = "";
				this.user.phone  = "";
				this.service.hideModal("#agregarUser");
				this.ngOnInit();
			}
		});
	}


	editar(user){
		if(user.hasOwnProperty("_id")) this.actual_id = user._id;
		else this.actual_id = user.id;

		this.user.givenname = user.givenname;
		this.user.lastname = user.lastname;
		this.user.document = user.document;
		this.user.mail = user.mail;
		this.user.phone  = user.phone;
		this.action = "edit";
		this.service.presentModal("#agregarUser");
	}

	eliminar(user){
		console.log(user)
		let confirmar = (result) => {
	      if (result.isConfirmed) {  
	        let _id;

	        if(user.hasOwnProperty("_id")) _id = user._id;
			else _id = user.id;

	        this.service.delUser({ _id: _id }, (data) =>{
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
