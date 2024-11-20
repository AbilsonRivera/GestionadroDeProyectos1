import { Component } from '@angular/core';
import { AuthService } from '../services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'],
})
export class LoginPage {
  email: string = '';
  password: string = '';
  errorMessage: string = ''; // Inicializa errorMessage

  constructor(private authService: AuthService, private router: Router) {}

  onSubmit() {
    this.authService.login({ email: this.email, password: this.password }).subscribe(
      response => {
        console.log('Inicio de sesión exitoso', response);
        this.router.navigate(['/projects']);
        this.errorMessage = ''; // Limpiar el mensaje de error si el inicio es exitoso
      },
      error => {
        console.error('Error en el inicio de sesión', error);
        this.errorMessage = 'Credenciales inválidas. Por favor intenta de nuevo.'; // Establecer el mensaje de error
      }
    );
  }
}
