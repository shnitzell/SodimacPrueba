import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';


import { LoginComponent } from './pages/login/login.component';
import { ListUserComponent } from './pages/list-user/list-user.component';

const routes: Routes = [
		{ path: '', redirectTo:'home', pathMatch: 'full' },
		{ path: 'home', component: LoginComponent },
		{ path: 'list', component: ListUserComponent },
		{ path: '**', pathMatch: 'full', redirectTo: '' }
	];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
