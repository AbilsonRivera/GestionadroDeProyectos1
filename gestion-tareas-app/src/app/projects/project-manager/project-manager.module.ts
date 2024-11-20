// src/app/projects/project-manager/project-manager.module.ts
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonicModule } from '@ionic/angular';
import { RouterModule, Routes } from '@angular/router';

import { ProjectManagerComponent } from './project-manager.component';

const routes: Routes = [
  {
    path: '',
    component: ProjectManagerComponent
  }
];

@NgModule({
  declarations: [ProjectManagerComponent],
  imports: [
    CommonModule,
    FormsModule,
    IonicModule,
    RouterModule.forChild(routes)  // Configura las rutas para cargar ProjectManagerComponent
  ],
})
export class ProjectManagerModule {}
