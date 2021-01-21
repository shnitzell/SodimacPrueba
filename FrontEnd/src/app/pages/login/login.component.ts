import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

import { ApiService } from '../../../services/api.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {
	public userName: string = "";
	public password: string = "";

	public param: any = {
		type: "",
		message: ""
	}

  	constructor( private service: ApiService, private router: Router) { }

  	ngOnInit(): void {
  		let logged = localStorage.getItem("Logged");
  		if(logged != null){
  			if(logged == "true")
  				this.router.navigate(["list"]);
  		}
  	}

  	login(){
  		if(this.userName == "" || this.password == ""){
  			this.service.presentToast("¡Error!", "Los campos no pueden ser vacíos", "error");
  			return;
  		}else{

  			if(this.userName == "root")
  				if(this.password == "123"){
  					localStorage.setItem("Logged", "true");
  					this.router.navigate(["list"]);
  				}
  				else
  					this.service.presentToast("¡Error!", "La contraseña no coincide", "error");
  			else
  				this.service.presentToast("¡Error!", "No existe usuario", "error");
  		}

  	}

}
