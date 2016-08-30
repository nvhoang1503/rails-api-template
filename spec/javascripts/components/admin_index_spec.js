var TestUtils = React.addons.TestUtils;

describe("AdminIndex", function() {
    var component;
    describe("renders Index", function() {
        beforeEach(function() {
            component = TestUtils.renderIntoDocument(
                React.createElement(AdminIndex, {
                    admins: [{
                        id: "1",
                        email: "test@test.com",
                        created_at: "1/1/2006"
                    }]
                })
            );
        });

        it("should have admin table rendered", function() {
            var c =  $(ReactDOM.findDOMNode(component))
            expect(c.find("td")[0].textContent).toContain("1")
        });
    });
});
