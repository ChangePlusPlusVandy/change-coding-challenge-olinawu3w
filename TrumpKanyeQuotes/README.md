# TrumpKanyeQuotes Project

## Description

The project is an ios app (13.0+) that fetches quotes by Dounald Trump and Kanye West from the APIs linked below. The user will be prompted to guess the person who said the quote.
There will be 10 questions in total in this game. In the end, a score in out of ten will be displayed with a comment on the performance.

## Installation

This project is programmed in Swift 5 and with Xcode 12.0. Other than Xcode, no other installation is needed.

## A Note

I sadly could not use the `@twitterapi` for this application.

The reason is because I applied for a twitter developer three times and I was denied three times. I'm not sure why they denied me, so I emailed Ethan for an alternative. He was so helpful and understanding, and introduced me to two other APIs that fetch quotes from Kanye and Trump: (the link is below)

<ol>
    <li>https://api.whatdoestrumpthink.com/api/v1/quotes/random</li>
    <li>https://kanye.rest</li>
</ol>

The API offers random selection of each person's quote. Therefore, I could not make a request for multiple quotes. Each quote will be fetched after the user has completed one question. Also, this means that certain quotes may repeat itselves.
