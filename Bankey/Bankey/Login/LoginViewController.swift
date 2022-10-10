
import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let appNameLabel = UILabel()
    let appDescriptionLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    weak var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    var password: String? {
        return loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }


}

extension LoginViewController {

    private func style() {
        
        appNameLabel.translatesAutoresizingMaskIntoConstraints = false
        appNameLabel.text = "Bankey"
        appNameLabel.font = appNameLabel.font.withSize(35)
        
        appDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        appDescriptionLabel.numberOfLines = 0
        appDescriptionLabel.text = "Your premium source for all things banking!"
        appDescriptionLabel.font = appDescriptionLabel.font.withSize(20)
        appDescriptionLabel.textAlignment = .center
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign IN", for: .normal)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.text = "You should enter the name and password."
        errorMessageLabel.isHidden = true
    }

    private func layout() {
        view.addSubview(appNameLabel)
        view.addSubview(appDescriptionLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        // AppNameLabel
        NSLayoutConstraint.activate([
            appDescriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: appNameLabel.bottomAnchor, multiplier: 6),
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        // AppDescriptionLabel
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescriptionLabel.bottomAnchor, multiplier: 4),
            appDescriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: loginView.leadingAnchor, multiplier: 6),
            loginView.trailingAnchor.constraint(equalToSystemSpacingAfter: appDescriptionLabel.trailingAnchor, multiplier: 6)
        ])
        
//        NSLayoutConstraint.activate([
//            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appDescriptionLabel.bottomAnchor, multiplier: 4),
//            appDescriptionLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
//            appDescriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
//        ])
        
        // LoginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
        
        // SignInButton
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // ErrorMessageLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
    }
}

// MARK: - Actions
extension LoginViewController {
    @IBAction func signInButtonTapped(sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password shouldn't be nil")
            return
        }
        
        // Example by Rassmuson
//        if username == "" || password == "" {
//            configureView(withMessage: "You should enter username and password")
//            return
//        }
//        if username == "Sasha" && password == "Silin" {
//            configureView(withMessage: "SUCCESS")
//        } else {
//            configureView(withMessage: "You entered incorrect username or password")
//        }
        
        // Mine example
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "You should enter username and password")
        } else {
            attachingEnterParameters()
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
    private func attachingEnterParameters() {
        if username == "Sasha" && password == "Silin" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "You entered incorrect username or password")
        }
    }
}
