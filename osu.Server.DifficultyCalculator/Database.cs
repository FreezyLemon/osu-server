// Copyright (c) 2007-2018 ppy Pty Ltd <contact@ppy.sh>.
// Licensed under the MIT Licence - https://raw.githubusercontent.com/ppy/osu-server/master/LICENCE

using System;
using System.Threading;
using MySql.Data.MySqlClient;

namespace osu.Server.DifficultyCalculator
{
    public class Database
    {
        private readonly string connectionString;

        public Database(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public MySqlConnection GetConnection()
        {
            var connection = new MySqlConnection(connectionString);

            int retryCount = 0;
            while (!connection.Ping())
            {
                if (++retryCount > 100)
                {
                    throw new InvalidOperationException("MySQL connection not available after a lot of retries!");
                }

                Console.WriteLine("MySQL Connection failed! Retrying in 5 seconds...");
                // Wait 5 seconds and try again
                Thread.Sleep(5000);
            }

            connection.Open();
            Console.WriteLine("Connected to MySQL database!");
            return connection;
        }
    }
}
