import SectionsTableView
import SnapKit
import ThemeKit
import RxSwift
import RxCocoa
import MessageUI
import SafariServices
import ComponentKit

class AboutViewController: ThemeViewController {
    private let viewModel: AboutViewModel
    private let disposeBag = DisposeBag()

    private let tableView = SectionsTableView(style: .grouped)

    private let headerCell = TermsHeaderCell()
    private let termsCell = A3Cell()

    init(viewModel: AboutViewModel) {
        self.viewModel = viewModel

        super.init()

        hidesBottomBarWhenPushed = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "settings.about_app.title".localized
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)

        view.addSubview(tableView)
        tableView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.sectionDataSource = self

        tableView.registerCell(forClass: A1Cell.self)

        headerCell.bind(
                image: UIImage(named: "scorepios"),
                title: "settings.about_app.app_name".localized,
                subtitle: "version".localized(viewModel.appVersion)
        )

        termsCell.set(backgroundStyle: .lawrence, isLast: true)
        termsCell.titleImage = UIImage(named: "unordered_20")
        termsCell.title = "terms.title".localized

        subscribe(disposeBag, viewModel.termsAlertDriver) { [weak self] alert in
            self?.termsCell.valueImage = alert ? UIImage(named: "warning_2_20")?.tinted(with: .themeLucian) : nil
        }
        subscribe(disposeBag, viewModel.openLinkSignal) { [weak self] url in
            self?.present(SFSafariViewController(url: url, configuration: SFSafariViewController.Configuration()), animated: true)
        }

        tableView.buildSections()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.deselectCell(withCoordinator: transitionCoordinator, animated: animated)
    }

    private func openTellFriends() {
        let text = "settings_tell_friends.text".localized + "\n" + viewModel.appWebPageLink
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: [])
        present(activityViewController, animated: true, completion: nil)
    }

    private func handleContact() {
        let email = viewModel.contactEmail

        if MFMailComposeViewController.canSendMail() {
            let controller = MFMailComposeViewController()
            controller.setToRecipients([email])
            controller.mailComposeDelegate = self

            present(controller, animated: true)
        } else {
            UIPasteboard.general.setValue(email, forPasteboardType: "public.plain-text")
            HudHelper.instance.showSuccess(title: "settings.about_app.email_copied".localized)
        }
    }

}

extension AboutViewController: SectionsDataSource {

    func buildSections() -> [SectionProtocol] {
        [
            Section(
                    id: "header",
                    headerState: .margin(height: .margin8),
                    footerState: .margin(height: .margin16),
                    rows: [
                        StaticRow(
                                cell: headerCell,
                                id: "header",
                                height: TermsHeaderCell.height
                        )
                    ]
            ),

            Section(
                    id: "main",
                    footerState: .margin(height: .margin32),
                    rows: [
                        Row<A1Cell>(
                                id: "app-status",
                                height: .heightCell48,
                                bind: { cell, _ in
                                    cell.set(backgroundStyle: .lawrence, isFirst: true)
                                    cell.titleImage = UIImage(named: "app_status_20")
                                    cell.title = "app_status.title".localized
                                },
                                action: { [weak self] _ in
                                    self?.navigationController?.pushViewController(AppStatusRouter.module(), animated: true)
                                }
                        ),
                        StaticRow(
                                cell: termsCell,
                                id: "terms",
                                height: .heightCell48,
                                action: { [weak self] in
                                    self?.navigationController?.pushViewController(TermsRouter.module(), animated: true)
                                }
                        )
                    ]
            ),

            Section(
                    id: "web",
                    footerState: .margin(height: .margin32),
                    rows: [
                   
                        Row<A1Cell>(
                                id: "website",
                                height: .heightCell48,
                                autoDeselect: true,
                                bind: { cell, _ in
                                    cell.set(backgroundStyle: .lawrence, isLast: true)
                                    cell.titleImage = UIImage(named: "globe_20")
                                    cell.title = "settings.about_app.website".localized
                                },
                                action: { [weak self] _ in
                                    self?.viewModel.onTapWebPageLink()
                                }
                        ),
                        Row<A1Cell>(
                                id: "website",
                                height: .heightCell48,
                                autoDeselect: true,
                                bind: { cell, _ in
                                    cell.set(backgroundStyle: .lawrence, isLast: true)
                                    cell.titleImage = UIImage(named: "globe_20")
                                    cell.title = "settings.about_app.website".localized
                                },
                                action: { [weak self] _ in
                                    self?.viewModel.onTapWebPageLink()
                                }
                        )
                    ]
            ),
            Section(
                    id: "share",
                    footerState: .margin(height: .margin32),
                    rows: [
                        Row<A1Cell>(
                                id: "rate-us",
                                height: .heightCell48,
                                autoDeselect: true,
                                bind: { cell, _ in
                                    cell.set(backgroundStyle: .lawrence, isFirst: true)
                                    cell.titleImage = UIImage(named: "rate_20")
                                    cell.title = "settings.about_app.rate_us".localized
                                },
                                action: { [weak self] _ in
                                    self?.viewModel.onTapRateApp()
                                }
                        ),
                        Row<A1Cell>(
                                id: "tell-friends",
                                height: .heightCell48,
                                autoDeselect: true,
                                bind: { cell, _ in
                                    cell.set(backgroundStyle: .lawrence, isLast: true)
                                    cell.titleImage = UIImage(named: "share_1_20")
                                    cell.title = "settings.about_app.tell_friends".localized
                                },
                                action: { [weak self] _ in
                                    self?.openTellFriends()
                                }
                        )
                    ]
            ),
            Section(
                    id: "contact",
                    footerState: .margin(height: .margin32),
                    rows: [
                        Row<A1Cell>(
                                id: "email",
                                height: .heightCell48,
                                autoDeselect: true,
                                bind: { cell, _ in
                                    cell.set(backgroundStyle: .lawrence, isFirst: true, isLast: true)
                                    cell.titleImage = UIImage(named: "at_20")
                                    cell.title = "settings.about_app.contact".localized
                                },
                                action: { [weak self] _ in
                                    self?.handleContact()
                                }
                        )
                    ]
            )
        ]
    }

}

extension AboutViewController: MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
