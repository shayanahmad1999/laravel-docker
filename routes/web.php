<?php

use App\Models\User;
use Illuminate\Database\QueryException;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('createUser', function () {
    try {
        User::create([
            'name' => 'Shayan',
            'email' => 'shayan@gmail.com',
            'password' => 'shayan1122'
        ]);
        return response()->json([
            'status' => 200,
            'message' => 'User Created successfully',
        ], 200);
    } catch (QueryException $e) {

        if (str_contains($e->getMessage(), 'Integrity constraint violation')) {
            return response()->json([
                'status' => 422,
                'message' => 'The email address is already in use.',
                'error_details' => $e->getMessage()
            ], 422);
        }

        return response()->json([
            'status' => 500,
            'message' => 'A database error occurred while creating the user.',
            'error_details' => $e->getMessage()
        ], 500);
    } catch (\Exception $e) {
        return response()->json([
            'status' => 500,
            'message' => 'An unexpected error occurred.',
            'error_details' => $e->getMessage()
        ], 500);
    }
});

Route::get('getUsers', function () {
    return response()->json([
        'status' => 200,
        'data' => User::all(),
    ]);
});
