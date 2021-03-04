import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


import { LoginComponent } from './pages/login/login.component';
import { ListClientesComponent } from './pages/list-clientes/list-clientes.component';

const routes: Routes = [
		{ path: '', redirectTo:'home', pathMatch: 'full' },
		{ path: 'home', component: LoginComponent },
		{ path: 'list', component: ListClientesComponent },
		{ path: '**', pathMatch: 'full', redirectTo: '' }
	];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
