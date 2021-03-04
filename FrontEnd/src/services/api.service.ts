import { Injectable } from '@angular/core';
import { environment } from '../environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { map } from "rxjs/operators";

import Swal from 'sweetalert2';

declare var $: any;

@Injectable({
    providedIn: 'root'
})
export class ApiService{

    private api = environment.api; 
    private headers = new HttpHeaders();
    private accesstype: any = [];
    msgSended = false;

    constructor(private httpClient:HttpClient){
        this.headers.append('Access-Control-Allow-Origin', '*');
        this.headers.append('Content-Type', 'application/x-www-urlencoded');
        this.headers.append('No-Auth', 'True');
    }

    presentModal(modalid: string){
      $(modalid).modal("show");
    }

    hideModal(modalid){
      $(modalid).modal("hide"); 
    }

    async presentAlertConfirm(title, mensaje, additionalOpt = null, callback = null ) {

        let options = {
          title: title,
          text: mensaje
        }

        if(additionalOpt != null)
          for(let it in additionalOpt)
            options[ it ] = additionalOpt[it];          

        Swal.fire(options).then(callback);
    }

    async presentToast( title, mensaje, type = "success") {      
        switch(type){
          case "success":
            Swal.fire(title, mensaje, "success");
          break;
          case "error":
            Swal.fire(title, mensaje, "error");
          break;
          case "warning":
            Swal.fire(title, mensaje, "warning");
          break;
          case "info":
            Swal.fire(title, mensaje, "info");
          break;
          case "question":
            Swal.fire(title, mensaje, "question");
          break;
        }     
    }


    async doRequest (url, params, callBack, type , headers: any = {}){

        let load ={
          title: 'Cargando',
          html: 'Por favor, espere...',
          allowOutsideClick: false,
          allowEnterKey: false,
          allowEscapeKey: false,
          willOpen: () => {
            Swal.showLoading();            
          }         
        }

        if( !params.hasOwnProperty("DisableLoad") ) Swal.fire(load);
        if( typeof params == "string") if( !params.includes("DisableLoad")) Swal.fire(load);

        switch( type.toUpperCase() ){
            case 'GET':
                this.httpClient.get(url, headers)
                            .pipe( map( resp => { return resp; } ) )
                            .subscribe(callBack, er => {
                                this.presentToast("Error: ", er, "error");
                               //Swal.close();
                            }, () => {
                             //Swal.close();
                            });                            
            break;

            case 'POST':
                this.httpClient.post(url, params, headers)
                            .pipe( map( resp => { return resp; } ) )
                            .subscribe(callBack, er => {
                                try{
                                    er = JSON.stringify(er);
                                    this.presentToast("Error: ", er, "error");
                                }catch(e){
                                    this.presentToast("Error: ", er, "error");
                                } 
                               //Swal.close();                               
                            }, () => {
                             //Swal.close();
                            });
            break;
        }
    };

    closeDialog(){
      Swal.close();
    }

    setClientes( userData: any, callBack ){        
        this.doRequest(`${this.api}/clientes/set`, userData, callBack, 'post');
    }    

    getClientes( callBack ){
        this.doRequest(`${this.api}/clientes/list`, {}, callBack, 'post');
    }

    putClientes( userData: any, callBack ){
       this.doRequest(`${this.api}/clientes/put`, userData, callBack, 'post');
    }

    delClientes( userData: any, callBack ){
       this.doRequest(`${this.api}/clientes/del`, userData, callBack, 'post');
    }

}


