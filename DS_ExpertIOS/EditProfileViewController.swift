//
//  EditProfileViewController.swift
//  DS_ExpertIOS
//
//  Created by Admin on 24/02/24.
//

import UIKit
import DSCore
import DSBase

class EditProfileViewController: UIViewController {
    private let presenter: EditProfilePresenter
    private let imagePicker = UIImagePickerController()

    private let imgSize: CGFloat = 150
    private let space: CGFloat = 20

    let stackView = UIStackView()
    let ivProfile = UIImageView()
    let btnGetImage = UIButton(type: .system)
    let formFirstName = createForm(formTitle: "First Name")
    let formLastName = createForm(formTitle: "Last Name")
    let formCity = createForm(formTitle: "Address")
    let formDescription = createForm(formTitle: "Description")
    let btnSave = UIButton(type: .custom)

    init(presenter: EditProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        onDataSet()
    }

    func onDataSet() {
        navigationItem.title = "Edit Profile"
        navigationItem.leftBarButtonItem = barBtnBack()

        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary

        presenter.$userModel
            .sink { userResult in
                if let userModel = userResult {
                    if let avatar = userModel.avatar {
                        self.ivProfile.image = UIImage(data: avatar)
                    } else {
                        self.ivProfile.image = UIImage(systemName: "person.circle.fill")
                    }
                    self.setValueForm(form: self.formFirstName, value: userModel.firstName)
                    self.setValueForm(form: self.formLastName, value: userModel.lastName)
                    self.setValueForm(form: self.formCity, value: userModel.address)
                    self.setValueForm(form: self.formDescription, value: userModel.description)
                }
            }
            .store(in: &presenter.cancellables)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getUser()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EditProfileViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = space
        stackView.setCustomSpacing(space * 2, after: btnGetImage)

        ivProfile.translatesAutoresizingMaskIntoConstraints = false
        ivProfile.contentMode = .scaleAspectFill
        ivProfile.layer.borderWidth = 1
        ivProfile.layer.masksToBounds = false
        ivProfile.layer.borderColor = UIColor.black.cgColor
        ivProfile.layer.cornerRadius = imgSize / 2
        ivProfile.clipsToBounds = true

        btnGetImage.translatesAutoresizingMaskIntoConstraints = false
        btnGetImage.setTitle("Get Image", for: .normal)
        btnGetImage.addTarget(self, action: #selector(handleGetImage), for: .touchUpInside)

        formFirstName.translatesAutoresizingMaskIntoConstraints = false
        formLastName.translatesAutoresizingMaskIntoConstraints = false
        formCity.translatesAutoresizingMaskIntoConstraints = false
        formDescription.translatesAutoresizingMaskIntoConstraints = false

        btnSave.translatesAutoresizingMaskIntoConstraints = false
        btnSave.setTitle("Save Profile", for: .normal)

        let titleBtnFont = UIFont.preferredFont(forTextStyle: .body)
        let titleBtnPointSize = titleBtnFont.pointSize
        let boldBtnTitleFont = UIFont.systemFont(ofSize: titleBtnPointSize, weight: .medium)

        let attributes: [NSAttributedString.Key: Any] = [.font: boldBtnTitleFont, .foregroundColor: UIColor.white]
        let attributedTitle = NSAttributedString(string: "Save Profile", attributes: attributes)
        btnSave.setAttributedTitle(attributedTitle, for: .normal)

        btnSave.backgroundColor = .systemBlue
        btnSave.layer.cornerRadius = btnSave.intrinsicContentSize.height / 2
        btnSave.clipsToBounds = true
        btnSave.addTarget(self, action: #selector(handleSaveProfile), for: .touchUpInside)
    }

    func layout() {
        addToSubView(
            stackView, items: ivProfile, btnGetImage, formFirstName, formLastName, formCity, formDescription, createSpacer(), btnSave
        )

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: space),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -space),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            ivProfile.widthAnchor.constraint(equalToConstant: imgSize),
            ivProfile.heightAnchor.constraint(equalToConstant: imgSize),

            formFirstName.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -(space * 2)),
            formLastName.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -(space * 2)),
            formCity.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -(space * 2)),
            formDescription.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -(space * 2)),
            btnSave.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -(space * 2))
        ])
    }
}

extension EditProfileViewController {
    static func createForm(formTitle: String) -> UIStackView {
        let containerForm = UIStackView()
        let lable = UILabel()
        let form = UITextField()

        containerForm.axis = .vertical
        containerForm.alignment = .fill
        containerForm.distribution = .fill
        containerForm.spacing = 10

        lable.text = formTitle
        lable.font = UIFont.preferredFont(forTextStyle: .caption2)

        form.borderStyle = .roundedRect

        containerForm.addArrangedSubview(lable)
        containerForm.addArrangedSubview(form)

        return containerForm
    }

    @objc func handleGetImage(sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func handleSaveProfile(sender: UIButton) {
        let warningTitle = "Warning"

        guard let firstName = getValueForm(form: formFirstName) else {
            alert(title: warningTitle, message: "The First Name field can't be empty!", isSuccess: false)
            return
        }
        guard let lastName = getValueForm(form: formLastName) else {
            alert(title: warningTitle, message: "The Last Name field can't empty!", isSuccess: false)
            return
        }
        guard let address = getValueForm(form: formCity) else {
            alert(title: warningTitle, message: "The Address field can't empty!", isSuccess: false)
            return
        }
        guard let description = getValueForm(form: formDescription) else {
            alert(title: warningTitle, message: "The Description field can't empty!", isSuccess: false)
            return
        }

        if let image = ivProfile.image, let data = image.pngData() as Data? {
            presenter.updateUser(userModel: UserModel(
                firstName: firstName,
                lastName: lastName,
                avatar: data,
                description: description,
                address: address
            ))
            alert(title: "Sucess", message: "Profile data saved", isSuccess: true)

        } else {
            alert(title: "Failed", message: "Failed to save Profile", isSuccess: false)
        }
    }

    func createSpacer() -> UIView {
        let spacer = UIView()
        spacer.isUserInteractionEnabled = false
        spacer.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        return spacer
    }

    func setValueForm(form: UIStackView, value: String) {
        form.subviews.forEach { view in
            if let formView = view as? UITextField {
                formView.text = value
            }
        }
    }

    func getValueForm(form: UIStackView) -> String? {
        var text: String?
        form.subviews.forEach { view in
            if let formView = view as? UITextField {
                text = formView.text

                if let textChecker = text, textChecker.isEmpty {
                    text = nil
                }
            }
        }
        return text
    }

    func alert(title: String, message: String, isSuccess: Bool) {
        let allertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        allertController.addAction(
            UIAlertAction(
                title: isSuccess ? "OK" : "Dismiss", style: isSuccess ? .default : .cancel
            ) { _ in
              if isSuccess {
                self.dismiss(animated: true) {
                  self.displayToast(
                    "Profile edited successfully", width: UIScreen.main.bounds.size.width - 40
                  )
                }
              }
            }
        )
        present(allertController, animated: true, completion: nil)
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let result = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            ivProfile.image = result
            dismiss(animated: true, completion: nil)
        } else {
            alert(title: "Failed", message: "Image can't be loaded.", isSuccess: false)
        }
    }
}
