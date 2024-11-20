import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { RouterModule, Routes } from '@angular/router';

import { TaskManagerComponent } from './task-manager.component';

const routes: Routes = [
  {
    path: '',
    component: TaskManagerComponent
  }
];

@NgModule({
  declarations: [TaskManagerComponent],
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes) // Configura la ruta para el TaskManagerComponent
  ]
})
export class TaskManagerModule {}
