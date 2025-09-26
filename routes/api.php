<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\CustomerController;

Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('customers', CustomerController::class);
});
