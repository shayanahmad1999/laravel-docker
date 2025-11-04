<?php

namespace App\Console\Commands;

use App\Models\User;
use Illuminate\Console\Command;

class TestCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:test';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        info(now());
        User::create([
            'name' => 'Test ' . rand(1, 1000),
            'email' => 'test' . time() . '@gmail.com',
            'password' => '12345678'
        ]);
    }
}
