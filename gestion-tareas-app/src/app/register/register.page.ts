import { Component } from '@angular/core';
import { AuthService } from '../services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.page.html',
  styleUrls: ['./register.page.scss'],
})
export class RegisterPage {
  name: string = '';
  email: string = '';
  password: string = '';

  constructor(private authService: AuthService, private router: Router) {}

  onSubmit() {
    this.authService.register({ name: this.name, email: this.email, password: this.password }).subscribe(
      response => {
        console.log('Registro exitoso', response);
        // Redirigir a la página de inicio de sesión o la página principal
        this.router.navigate(['/login']);
      },
      error => {
        console.error('Error en el registro', error);
        // Maneja el error, como mostrar un mensaje
      }
    );
  }
}
