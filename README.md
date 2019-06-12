# Optimal Queries using Active Record

## Learning Goals

* Use ActiveRecord's AREL library to build optimized queries

## Introduction

In programming, a good maxim is this:

> Use the best tool for the job

For example, you don't want to use JavaScript to build a computer for flying to
the Moon. JavaScript doesn't have very good decimal precision and, at distances
as far as the Moon, getting a number off in the hundred-thousandths point after
the decimal is the difference between landing on that celestial orb or taking a
long trip through nothing, forever.

Databases are AMAZING at linking and summarizing data. Ruby is a nice
general-purpose programming language. So when we need to get data from a
database, we want to ask the DATABASE to do as much of that work as possible.
That's what it's good at. That's what it likes to do. It has sacrificed some
capabilities in order to do other capabilities ***extremely well***.

While:

```ruby
doctors = Doctor.all
first_five_drs = doctors[0..5]
```

Will get you five doctors, using _RUBY_ to "section off" six doctors using
Ruby's range method (`[]`). But under the covers we asked the database for
**all** the doctors and then took six of them. Wouldn't it make more sense to
ask the database to get us ***only*** six `Doctor`s in the first place? That's
what the following code does:

```ruby
Doctor.limit(5).to_a
```

Functions like `limit` are provided by the "AREL" engine that's built into
ActiveRecord. AREL stands for "A Relational Algebra." If that sounds like some
complex, awesome Mathematics and set theory stuff, it is! Fortunately, we don't
have to get advanced degrees in mathematics to benefit from this engine. AREL
lets us query the database, via ActiveRecord in an object-oriented-looking way
***but*** that uses as much of the database's power as possible.

## Use ActiveRecord's AREL Library To Build Optimized Queries

In this lab, we've provided the solution (commented out) to the tests. You
should step through the tests and "fix" each method to make the test pass. 

As you uncomment, be sure to evaluate the implementation we've provided you.
Methods like `order`, `where`, `includes` are all part of the AREL engine. You
should look up these methods in the [AREL documentation][ad], and see how
they're working to filter the data retrieved from the database before the
result "gets to Ruby-land."

## Conclusion

While it's not necessary to memorize all the chainable methods AREL provides
ActiveRecord, it's best to know some of the common methods you saw in this
lab. If you are working in a Rails environment realizing that AREL can make
your queries more efficient can literally speed up your applications 1000x!

## Resources

* [AREL Documentation][ad]
* [ThoughtBot](http://thoughtbot.com/) - [Using Arel to Compose SQL Queries](http://robots.thoughtbot.com/using-arel-to-compose-sql-queries)

[ad]: https://guides.rubyonrails.org/active_record_querying.html

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/arel-lab' title='AREL Lab'>AREL Lab</a> on Learn.co and start learning to code for free.</p>
