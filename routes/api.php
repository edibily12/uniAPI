<?php

use App\Http\Controllers\api\v1\StudentController;
use App\Http\Controllers\api\v1\SubjectController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/students', [StudentController::class, 'index']);
Route::get('/subjects', [SubjectController::class, 'index']);

