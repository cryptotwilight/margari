import React from 'react'

import {
  CAvatar,
  CButton,
  CButtonGroup,
  CCard,
  CCardBody,
  CCardFooter,
  CCardHeader,
  CCol,
  CForm,
  CFormInput,
  CFormLabel,
  CFormTextarea,
  CProgress,
  CRow,
  CTable,
  CTableBody,
  CTableDataCell,
  CTableHead,
  CTableHeaderCell,
  CTableRow,
} from '@coreui/react'
import { CChartLine } from '@coreui/react-chartjs'
import { getStyle, hexToRgba } from '@coreui/utils'
import CIcon from '@coreui/icons-react'
import {
  cibCcAmex,
  cibCcApplePay,
  cibCcMastercard,
  cibCcPaypal,
  cibCcStripe,
  cibCcVisa,
  cibGoogle,
  cibFacebook,
  cibLinkedin,
  cifBr,
  cifEs,
  cifFr,
  cifIn,
  cifPl,
  cifUs,
  cibTwitter,
  cilCloudDownload,
  cilPeople,
  cilUser,
  cilUserFemale,
} from '@coreui/icons'

import avatar1 from 'src/assets/images/avatars/1.jpg'
import avatar2 from 'src/assets/images/avatars/2.jpg'
import avatar3 from 'src/assets/images/avatars/3.jpg'
import avatar4 from 'src/assets/images/avatars/4.jpg'
import avatar5 from 'src/assets/images/avatars/5.jpg'
import avatar6 from 'src/assets/images/avatars/6.jpg'

import WidgetsBrand from '../widgets/WidgetsBrand'
import WidgetsDropdown from '../widgets/WidgetsDropdown'

import { DocsExample } from 'src/components'

const MargariProjectAdmin = () => {
  const random = (min, max) => Math.floor(Math.random() * (max - min + 1) + min)

  const progressExample = [
    { title: 'Visits', value: '29.703 Users', percent: 40, color: 'success' },
    { title: 'Unique', value: '24.093 Users', percent: 20, color: 'info' },
    { title: 'Pageviews', value: '78.706 Views', percent: 60, color: 'warning' },
    { title: 'New Users', value: '22.123 Users', percent: 80, color: 'danger' },
    { title: 'Bounce Rate', value: 'Average Rate', percent: 40.15, color: 'primary' },
  ]

  const progressGroupExample1 = [
    { title: 'Monday', value1: 34, value2: 78 },
    { title: 'Tuesday', value1: 56, value2: 94 },
    { title: 'Wednesday', value1: 12, value2: 67 },
    { title: 'Thursday', value1: 43, value2: 91 },
    { title: 'Friday', value1: 22, value2: 73 },
    { title: 'Saturday', value1: 53, value2: 82 },
    { title: 'Sunday', value1: 9, value2: 69 },
  ]

  const progressGroupExample2 = [
    { title: 'Male', icon: cilUser, value: 53 },
    { title: 'Female', icon: cilUserFemale, value: 43 },
  ]

  const progressGroupExample3 = [
    { title: 'Organic Search', icon: cibGoogle, percent: 56, value: '191,235' },
    { title: 'Facebook', icon: cibFacebook, percent: 15, value: '51,223' },
    { title: 'Twitter', icon: cibTwitter, percent: 11, value: '37,564' },
    { title: 'LinkedIn', icon: cibLinkedin, percent: 8, value: '27,319' },
  ]

  const tableExample = [
    {
      avatar: { src: avatar1, status: 'success' },
      user: {
        name: 'Yiorgos Avraamu',
        new: true,
        registered: 'Jan 1, 2021',
      },
      country: { name: 'USA', flag: cifUs },
      usage: {
        value: 50,
        period: 'Jun 11, 2021 - Jul 10, 2021',
        color: 'success',
      },
      payment: { name: 'Mastercard', icon: cibCcMastercard },
      activity: '10 sec ago',
    },
    {
      avatar: { src: avatar2, status: 'danger' },
      user: {
        name: 'Avram Tarasios',
        new: false,
        registered: 'Jan 1, 2021',
      },
      country: { name: 'Brazil', flag: cifBr },
      usage: {
        value: 22,
        period: 'Jun 11, 2021 - Jul 10, 2021',
        color: 'info',
      },
      payment: { name: 'Visa', icon: cibCcVisa },
      activity: '5 minutes ago',
    },
    {
      avatar: { src: avatar3, status: 'warning' },
      user: { name: 'Quintin Ed', new: true, registered: 'Jan 1, 2021' },
      country: { name: 'India', flag: cifIn },
      usage: {
        value: 74,
        period: 'Jun 11, 2021 - Jul 10, 2021',
        color: 'warning',
      },
      payment: { name: 'Stripe', icon: cibCcStripe },
      activity: '1 hour ago',
    },
    {
      avatar: { src: avatar4, status: 'secondary' },
      user: { name: 'Enéas Kwadwo', new: true, registered: 'Jan 1, 2021' },
      country: { name: 'France', flag: cifFr },
      usage: {
        value: 98,
        period: 'Jun 11, 2021 - Jul 10, 2021',
        color: 'danger',
      },
      payment: { name: 'PayPal', icon: cibCcPaypal },
      activity: 'Last month',
    },
    {
      avatar: { src: avatar5, status: 'success' },
      user: {
        name: 'Agapetus Tadeáš',
        new: true,
        registered: 'Jan 1, 2021',
      },
      country: { name: 'Spain', flag: cifEs },
      usage: {
        value: 22,
        period: 'Jun 11, 2021 - Jul 10, 2021',
        color: 'primary',
      },
      payment: { name: 'Google Wallet', icon: cibCcApplePay },
      activity: 'Last week',
    },
    {
      avatar: { src: avatar6, status: 'danger' },
      user: {
        name: 'Friderik Dávid',
        new: true,
        registered: 'Jan 1, 2021',
      },
      country: { name: 'Poland', flag: cifPl },
      usage: {
        value: 43,
        period: 'Jun 11, 2021 - Jul 10, 2021',
        color: 'success',
      },
      payment: { name: 'Amex', icon: cibCcAmex },
      activity: 'Last week',
    },
  ]

  return (
    <>
      <CRow>
        <CCol xs={3}>
          <CCard className="mb-4">
            <CCardHeader>
              <strong>Import Profile</strong>
            </CCardHeader>
            <CCardBody>
              <CForm>
                <CFormLabel>Allo Profile Id</CFormLabel>
                <CFormInput type="text" id="import_profileId" placeholder="0x..." />
                <CButton value={'Import'}>Import Profile</CButton>
              </CForm>
            </CCardBody>
          </CCard>
          <CCard className="mb-4">
            <CCardHeader>
              <strong>Import Allo Pool</strong>
            </CCardHeader>
            <CCardBody>
              <CForm>
                <CFormLabel>Profile Id</CFormLabel>
                <CFormInput type="text" id="import_profileId" placeholder="0x..." />
                <CFormLabel>Pool Id</CFormLabel>
                <CFormInput type="text" id="import_poolId" placeholder="numeric" />
                <CButton value={'Import'}>Import Pool</CButton>
              </CForm>
            </CCardBody>
          </CCard>
        </CCol>
        <CCol xs={3}>
          <CCard className="mb-4">
            <CCardHeader>
              <strong>Add Margari Project Manager to Allo Profile Members</strong>
            </CCardHeader>
            <CCardBody>
              <CForm>
                <CFormLabel>Profile Id</CFormLabel>
                <CFormInput type="text" id="profileId" placeholder="0x..." />
                <CButton value={'Import'}>Add</CButton>
              </CForm>
            </CCardBody>
          </CCard>
          <CCard className="mb-4">
            <CCardHeader>
              <strong>Add Margari Project Manager to Allo Pool Managers</strong>
            </CCardHeader>
            <CCardBody>
              <CForm>
                <CFormLabel>Profile Id</CFormLabel>
                <CFormInput type="text" id="profileId" placeholder="0x..." />
                <CFormLabel>Pool Id</CFormLabel>
                <CFormInput type="text" id="poolId" placeholder="numeric" />
                <CButton value={'Import'}>Add</CButton>
              </CForm>
            </CCardBody>
          </CCard>
        </CCol>
        <CCol xs={3}>
          <CCard className="mb-4">
            <CCardHeader>
              <strong>Create Grant Project Funding Pool</strong>
            </CCardHeader>
            <CCardBody>
              <CForm>
                <CFormLabel>Organisation</CFormLabel>
                <CFormInput type="text" id="profileName" placeholder="name of organisation" />
                <CFormLabel>Token</CFormLabel>
                <CFormInput type="text" id="token" placeholder="0x..." />
                <CFormLabel>Grant Funds To Transfer</CFormLabel>
                <CFormInput type="text" id="funds" placeholder="numeric" />
                <CButton value={'Import'}>Approve Transfer</CButton>
                <CFormLabel>IPFS Hash to Detailed Grant Description</CFormLabel>
                <CFormInput
                  type="text"
                  id="metadata_ipfshash"
                  placeholder="e.g. bafkreifpaiuh6z4nxrvwdwdwtglvunkbh5x64rakiyna5sl4unrqp2qjdq"
                />
                <CFormLabel>Pool Administrators</CFormLabel>
                <CFormInput type="text" id="poolAdmins" placeholder="[0x...,0x...]" />
                <CButton value={'Import'}>Create Pool</CButton>
              </CForm>
            </CCardBody>
          </CCard>
        </CCol>
        <CCol xs={3}>
          <CCard className="mb-4">
            <CCardHeader>
              <strong>Create Margari Grant Funded Project</strong>
            </CCardHeader>
            <CCardBody>
              <CForm>
                <CFormLabel>Organisation</CFormLabel>
                <CFormInput type="text" id="profileName" placeholder="name of organisation" />
                <CFormLabel>Pool Id</CFormLabel>
                <CFormInput type="text" id="poolId" placeholder="numeric" />
                <CFormLabel>Project Name</CFormLabel>
                <CFormInput type="text" id="projectName" placeholder="name of project" />
                <CFormLabel>Project Budget</CFormLabel>
                <CFormInput type="text" id="projectBudget" placeholder="numeric" />
                <CButton value={'Import'}>Create Project</CButton>
              </CForm>
            </CCardBody>
          </CCard>
          <CCard className="mb-4">
            <CCardHeader>
              <strong>Add Deliverable To Project</strong>
            </CCardHeader>
            <CCardBody>
              <CForm>
                <CFormLabel>Project Id</CFormLabel>
                <CFormInput type="text" id="projectName" placeholder="id of project" />
                <CFormLabel>Name</CFormLabel>
                <CFormInput type="text" id="deliverableName" placeholder="name" />
                <CFormLabel>Deliverable Award</CFormLabel>
                <CFormInput type="text" id="projectName" placeholder="payout amount" />
                <CFormLabel>Deliverable Details (Ipfshash)</CFormLabel>
                <CFormInput
                  type="text"
                  id="deliverableMetadata"
                  placeholder="deliverable details"
                />
                <CFormLabel>Assigned Contributor Id</CFormLabel>
                <CFormInput type="text" id="contributor" placeholder="numeric" />
                <CButton value={'Import'}>Create Deliverable</CButton>
              </CForm>
            </CCardBody>
          </CCard>
        </CCol>
      </CRow>
      <CRow>
        <CCol xs={12}>
          <CCard className="mb-4">
            <CCardHeader>
              <strong>My Margari Projects </strong>
              <small>Below are all the Margari which you are associated.</small>
            </CCardHeader>
            <CCardBody>
              <CTable>
                <CTableHead>
                  <CTableRow>
                    <CTableHeaderCell scope="col"># Project Id</CTableHeaderCell>
                    <CTableHeaderCell scope="col">Org Funder</CTableHeaderCell>
                    <CTableHeaderCell scope="col">Budget</CTableHeaderCell>
                    <CTableHeaderCell scope="col">Collaborators</CTableHeaderCell>
                  </CTableRow>
                </CTableHead>
                <CTableBody>
                  <CTableRow>
                    <CTableHeaderCell scope="row">1</CTableHeaderCell>
                    <CTableDataCell>Mark</CTableDataCell>
                    <CTableDataCell>Otto</CTableDataCell>
                    <CTableDataCell>@mdo</CTableDataCell>
                  </CTableRow>
                  <CTableRow>
                    <CTableHeaderCell scope="row">2</CTableHeaderCell>
                    <CTableDataCell>Jacob</CTableDataCell>
                    <CTableDataCell>Thornton</CTableDataCell>
                    <CTableDataCell>@fat</CTableDataCell>
                  </CTableRow>
                  <CTableRow>
                    <CTableHeaderCell scope="row">3</CTableHeaderCell>
                    <CTableDataCell>Larry the Bird</CTableDataCell>
                    <CTableDataCell>Thornton</CTableDataCell>
                    <CTableDataCell>@twitter</CTableDataCell>
                  </CTableRow>
                </CTableBody>
              </CTable>
            </CCardBody>
          </CCard>
        </CCol>
      </CRow>
    </>
  )
}

export default MargariProjectAdmin
