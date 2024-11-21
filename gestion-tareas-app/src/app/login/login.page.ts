import { Component } from '@angular/core'; 
import { AuthService } from '../services/auth.service';
import { Router } from '@angular/router'; 

@Component({
  selector: 'app-login',
  templateUrl: './login.page.html',
  styleUrls: ['./login.page.scss'], 
})
export class LoginPage {
  // Propiedades que representarán los campos del formulario de inicio de sesión
  email: string = ''; // Almacena el email ingresado por el usuario
  password: string = ''; // Almacena la contraseña ingresada por el usuario
  errorMessage: string = ''; // Inicializa la propiedad que almacenará el mensaje de error, si ocurre

  // Inyectamos los servicios necesarios en el constructor: AuthService para la autenticación y Router para la navegación
  constructor(private authService: AuthService, private router: Router) {}

  // Método que se ejecuta cuando el usuario envía el formulario de inicio de sesión
  onSubmit() {
    // Llamamos al servicio 'authService' para realizar el inicio de sesión con el email y la contraseña del formulario
    this.authService.login({ email: this.email, password: this.password }).subscribe(
      response => { // Si la respuesta es exitosa
        console.log('Inicio de sesión exitoso', response); // Mostramos el mensaje en consola para depuración
        this.router.navigate(['/projects']); // Redirigimos al usuario a la página de proyectos
        this.errorMessage = ''; // Limpiamos cualquier mensaje de error si el inicio de sesión fue exitoso
      },
      error => { // Si ocurre un error durante el inicio de sesión
        console.error('Error en el inicio de sesión', error); // Mostramos el error en la consola para depuración
        this.errorMessage = 'Credenciales inválidas. Por favor intenta de nuevo.'; // Establecemos el mensaje de error para mostrarlo al usuario
      }
    );
  }
}
