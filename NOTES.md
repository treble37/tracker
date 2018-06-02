## Documentation

### Running Locally

* Seed the database with rake db:seed. Some sample projects and tasks will be setup for you.
* Run `rspec` to see 19 passing tests.

### Explain what your project is and what it does

This adds a feature to a tracker.

"As a user I would like to add a new task to a project and manage the task states so that I can track the work I need to do. When a task is complete I would like to be notified via a text message that the task is complete."

### Tradeoffs / Limitations

#### Assumptions

* Due to the time-constrained nature of a sample project, I sometimes made "executive decisions" on the implementation of the tracker feature. I figured we could just discuss choices based on a concrete implementation and it might be more efficient than doing a back and forth in email. For example, I decided on the format of the text message sent to a user when a Task was moved to "done". I also used "in_progress" with an underscore in the enum state representation in Task.
* I assume that the project is to add to the API functionality (as opposed to adding a front-end).
* This application is designed to be run locally. There's no Heroku live instance.

#### Production / Other Considerations

* Ideally the call to the Twilio API with the sending of the text message should be in a background job of some kind. It was simply faster to implement by skipping the background job. This allowed for more test coverage. In a production scenario, you'd want the background job.
* I've never found Cucumber to be that useful in practice...
* No bulk create/destroy. Perhaps a need to create/destroy tasks in bulk could be useful, especially depending on the use case of the API (front end CMS with bulk edit/create functionality?).
* There is no authentication or authorization around destructive API actions. In a production situation, this is something you'd want to have. Depending on whether this is a public API or not, you might also want authorization / authentication around "read-only" actions.
* The swagger docs gem is outdated. It supports 1.2 and not the latest swagger specification. The Swagger UI Console chrome plugin also supports 2.0, though it seems to work with my current implementation.

#### Future Work

* Implement the implied features in the "Production / Other Consideration" section (e.g., upgrading swagger, authorization, etc.)
* Possibly write controller tests to consider pagination and error cases
* Use a state machine to transition states in tasks (right now we don't do any error checking around transitions and assume all user input is valid)
* Upgrade to factory_girl to factory_bot
* Think about implementing JSON API spec

### Viewing Swagger Documentation

You can generate swagger docs with `rake swagger:docs`. Then you can install the [Swagger UI Console chrome plugin](https://chrome.google.com/webstore/detail/swagger-ui-console/ljlmonadebogfjabhkppkoohjkjclfai?hl=en)

* View the Project API documentation at [http://localhost:3000/api/v1/projects.json](http://localhost:3000/api/v1/projects.json)
* View the Task API documentation at [http://localhost:3000/api/v1/tasks.json](http://localhost:3000/api/v1/tasks.json)

### Experimental Additions

* I added a bulk_update method, although in practice I would have asked the engineering manager / product stakeholder before doing something like this. I was just experimenting. In practice, it's possible front-end requirements could have required a bulk nested attribute update.
