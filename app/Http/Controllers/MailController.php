<?php

namespace App\Http\Controllers;

use App\Mail\DemoMail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

class MailController extends Controller
{
    public function index(Request $request)
    {
        $mailData = [
            'title' => 'Mail From shayanahmad1999',
            'body' => 'This is for tsting email using smtp.'
        ];

        Mail::to('backenddeveloper573@gmail.com')->queue(new DemoMail($mailData));

        info('Email is Send Successfully.');
    }
}
